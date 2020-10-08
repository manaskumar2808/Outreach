from django.urls import path

from .views import (
    PlaceListAPIView,
    # PlaceEasyListAPIView,
    # PlaceExpensiveListAPIView,
    # PlaceAdventurousListAPIView,
    # PlaceReligiousListAPIView,
    PlaceRetrieveAPIView,
    PlaceCreateAPIView,
    PlaceUpdateAPIView,
    PlaceDeleteAPIView,
)

urlpatterns = [
    path('',PlaceListAPIView.as_view(),name='place-list-api'),
    # path('easy/',PlaceEasyListAPIView.as_view(),name='place-easy-list-api'),
    # path('expensive/',PlaceExpensiveListAPIView.as_view(),name='place-expensive-list-api'),
    # path('adventurous/',PlaceAdventurousListAPIView.as_view(),name='place-adventurous-list-api'),
    # path('religious/',PlaceReligiousListAPIView.as_view(),name='place-religious-list-api'),
    path('<str:id>/',PlaceRetrieveAPIView.as_view(),name='place-retrieve-api'),
    path('create/',PlaceCreateAPIView.as_view(),name='place-create-api'),
    path('<str:id>/update/',PlaceUpdateAPIView.as_view(),name='place-update-api'),
    path('<str:id>/delete/',PlaceDeleteAPIView.as_view(),name='place-delete-api'),
]