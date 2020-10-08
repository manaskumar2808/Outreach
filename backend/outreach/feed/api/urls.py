from django.urls import path

from .views import (
    FeedListAPIView, 
    UserFeedListAPIView,
    FeedRetrieveAPIView,
    FeedCreateAPIView,
    FeedUpdateAPIView,
    FeedDeleteAPIView,
)

urlpatterns = [
    path('',FeedListAPIView.as_view(),name='feed-list-api'),
    path('<int:user>/feeds/',UserFeedListAPIView.as_view(),name='user-feed-list-api'),
    path('<int:id>/',FeedRetrieveAPIView.as_view(),name='feed-detail-api'),
    path('create/',FeedCreateAPIView.as_view(),name='feed-create-api'),
    path('update/<int:id>/',FeedUpdateAPIView.as_view(),name='feed-update-api'),
    path('delete/<int:id>/',FeedDeleteAPIView.as_view(),name='feed-delete-api'),
]