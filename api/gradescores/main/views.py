from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import permissions,viewsets
from .models import *
from .serializers import *


class PersonViewset(viewsets.ModelViewSet):
    queryset = Person.objects.all()
    serializer_class = PersonSerializer

