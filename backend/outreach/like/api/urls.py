from django.urls import path

from .views import (
    LikeListAPIView, 
    CLikeListAPIView,
    LikeCountAPIView,
    CLikeCountAPIView,
    IsLiked,
    CIsLiked,
    LikeLatestListAPIView,
    CLikeLatestListAPIView,
    LikeCreateAPIView,
    LikeUpdateAPIView,
    LikeDeleteAPIView,
    UnlikeAPIView,
    CUnlikeAPIView,
)

urlpatterns = [
    ###### Feed Likes API Views ###### 
    path('<int:feed>/likes/count/',LikeCountAPIView.as_view(),name='like-count-api'),
    path('<int:feed>/unlike/<int:user>/',UnlikeAPIView.as_view(),name='unlike-api'),
    path('<int:feed>/likes/<int:user>/',IsLiked.as_view(),name='like-check-api'),
    path('create/',LikeCreateAPIView.as_view(),name='like-create-api'),

    ###### Comment Likes API Views ######
    path('<str:comment>/comment/likes/count/',CLikeCountAPIView.as_view(),name='like-comment-count-api'),
    path('<str:comment>/comment/unlike/<int:user>/',CUnlikeAPIView.as_view(),name='unlike-comment-api'),
    path('<str:comment>/comment/likes/<int:user>/',CIsLiked.as_view(),name='like-comment-check-api'),

    ###### not used right now ######
    path('<int:feed>/likes/latest/',LikeLatestListAPIView.as_view(),name='like-latest-list-api'),
    path('<int:feed>/likes/',LikeListAPIView.as_view(),name='like-list-api'),
    path('<str:comment>/comment/likes/',CLikeListAPIView.as_view(),name='like-comment-list-api'),
    path('<int:feed>/update/<int:id>/',LikeUpdateAPIView.as_view(),name='like-update-api'),
    path('<int:feed>/delete/<int:user>/',LikeDeleteAPIView.as_view(),name='like-delete-api'),
]