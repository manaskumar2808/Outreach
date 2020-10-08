from django.urls import path

from .views import (
    FollowerListAPIView,
    FollowedListAPIView,
    FollowAPIView,
    UnfollowAPIView,
    IsFollowerAPIView,
    IsFollowedAPIView,
)

urlpatterns = [
    path('<int:user>/followers/',FollowerListAPIView.as_view(),name='follower-api'),
    path('<int:user>/followeds/',FollowedListAPIView.as_view(),name='followed-api'),
    path('follow/',FollowAPIView.as_view(),name='follow-api'),
    path('<int:follower>/unfollow/<int:followed>/',UnfollowAPIView.as_view(),name='unfollow-api'),
    path('<int:follower>/isfollower/<int:followed>/',IsFollowerAPIView.as_view(),name='isfollower-api'),
    path('<int:follower>/isfollowed/<int:followed>/',IsFollowedAPIView.as_view(),name='isfollowed-api'),
]