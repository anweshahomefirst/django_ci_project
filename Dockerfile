# Dockerfile in the project root

# ---- Stage 1: Build the React Frontend ----
FROM node:18-alpine AS frontend-builder

WORKDIR /app/frontend

# Copy package files and install dependencies
COPY frontend/package.json frontend/yarn.lock ./
RUN yarn install

# Copy the rest of the frontend code and build it
COPY frontend/ ./
RUN yarn build


# ---- Stage 2: Build the Python Backend ----
FROM python:3.11-slim AS python-backend

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

# Install dependencies
COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Django backend code
COPY backend/ .

# Copy the built frontend static files from the first stage
COPY --from=frontend-builder /app/frontend/build ./frontend/build

# Collect static files (Django command)
# This will move all static files (including React's) into STATIC_ROOT
RUN python manage.py collectstatic --noinput

# Expose port and run the server
EXPOSE 8000
CMD ["gunicorn", "myproject.wsgi:application", "--bind", "0.0.0.0:8000"]