# core/views.py
from django.http import HttpResponse, JsonResponse


def index(request):
    return HttpResponse("Hello, CI pipeline!")


# --- ADD THE NEW FUNCTION BELOW ---

def user_profile(request):
    # MISTAKE 1: An unused variable. A common "code smell".
    # user_id = request.GET.get('id')

    # MISTAKE 2: A "magic number". Best practice is to use named constants.
    # if request.user.age > 18:
    #     can_vote = True

    # MISTAKE 3: A clear bug. We are using JsonResponse without importing it.
    return JsonResponse({'name': 'John Doe', 'status': 'active'})