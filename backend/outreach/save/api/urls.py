from django.urls import path

from .views import (
    SaveListAPIView, 
    SaveCountAPIView,
    IsSaved,
    SaveLatestListAPIView,
    SaveRetrieveAPIView,
    SaveCreateAPIView,
    SaveUpdateAPIView,
    SaveDeleteAPIView,
    UnsaveAPIView,
)

urlpatterns = [
    path('<int:feed>/unsave/<int:user>/',UnsaveAPIView.as_view(),name='unsave-api'),
    path('<int:feed>/saves/<int:user>/',IsSaved.as_view(),name='save-check-api'),
    path('<int:user>/saves/',SaveListAPIView.as_view(),name='save-list-api'),
    path('create/',SaveCreateAPIView.as_view(),name='save-create-api'),

    ###### not used right now ######
    path('<int:feed>/saves/count/',SaveCountAPIView.as_view(),name='save-count-api'),
    path('<int:user>/saves/latest/',SaveLatestListAPIView.as_view(),name='save-latest-list-api'),
    path('<int:feed>/update/<int:id>/',SaveUpdateAPIView.as_view(),name='save-update-api'),
    path('<int:feed>/delete/<int:user>/',SaveDeleteAPIView.as_view(),name='save-delete-api'),
]