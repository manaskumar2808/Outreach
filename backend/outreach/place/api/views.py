from rest_framework.generics import (
    ListAPIView,
    CreateAPIView,
    RetrieveAPIView,
    RetrieveUpdateAPIView,
    RetrieveDestroyAPIView,
)

from .serializers import PlaceSerializer
from ..models import Place

class PlaceListAPIView(ListAPIView):
    queryset = Place.objects.all()
    serializer_class = PlaceSerializer


class PlaceEasyListAPIView(ListAPIView):
    serializer_class = PlaceSerializer

    def get_queryset(self):
        queryset = Place.objects.filter(type='easy').order_by('-timestamp')

class PlaceExpensiveListAPIView(ListAPIView):
    serializer_class = PlaceSerializer

    def get_queryset(self):
        queryset = Place.objects.filter(type='expensive').order_by('-timestamp')

class PlaceAdventurousListAPIView(ListAPIView):
    serializer_class = PlaceSerializer

    def get_queryset(self):
        queryset = Place.objects.filter(type='adventurous').order_by('-timestamp')


class PlaceReligiousListAPIView(ListAPIView):
    serializer_class = PlaceSerializer

    def get_queryset(self):
        queryset = Place.objects.filter(type='religious').order_by('-timestamp')


class PlaceRetrieveAPIView(RetrieveAPIView):
    queryset = Place.objects.all()
    serializer_class = PlaceSerializer
    lookup_field = 'id'

class PlaceCreateAPIView(CreateAPIView):
    queryset = Place.objects.all()
    serializer_class = PlaceSerializer

class PlaceUpdateAPIView(RetrieveUpdateAPIView):
    queryset = Place.objects.all()
    serializer_class = PlaceSerializer
    lookup_field = 'id'

class PlaceDeleteAPIView(RetrieveDestroyAPIView):
    queryset = Place.objects.all()
    serializer_class = PlaceSerializer
    lookup_field = 'id'