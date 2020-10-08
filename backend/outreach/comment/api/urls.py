from django.urls import path

from .views import (
    CommentListAPIView, 
    CommentLatestListAPIView,
    CommentRetrieveAPIView,
    CommentCreateAPIView,
    CommentUpdateAPIView,
    CommentDeleteAPIView,

    ReplyListAPIView, 
    ReplyLatestListAPIView,
    ReplyRetrieveAPIView,
    ReplyCreateAPIView,
    ReplyUpdateAPIView,
    ReplyDeleteAPIView,

)

urlpatterns = [
    path('<int:feed>/comments/',CommentListAPIView.as_view(),name='comment-list-api'),
    path('<int:feed>/comments/latest/',CommentLatestListAPIView.as_view(),name='comment-latest-list-api'),
    path('<int:feed>/comments/<str:id>/',CommentRetrieveAPIView.as_view(),name='comment-detail-api'),
    path('create/',CommentCreateAPIView.as_view(),name='comment-create-api'),
    path('<int:feed>/update/<str:id>/',CommentUpdateAPIView.as_view(),name='comment-update-api'),
    path('delete/<str:id>/',CommentDeleteAPIView.as_view(),name='comment-delete-api'),

    path('<str:comment>/replies/',ReplyListAPIView.as_view(),name='comment-reply-list-api'),
    path('<str:comment>/replies/latest/',ReplyLatestListAPIView.as_view(),name='comment-latest-replies-list-api'),
    path('<str:comment>/replies/<str:id>/',ReplyRetrieveAPIView.as_view(),name='comment-reply-detail-api'),
    path('reply/create/',ReplyCreateAPIView.as_view(),name='comment-reply-create-api'),
    path('<str:comment>/replies/update/<str:id>/',ReplyUpdateAPIView.as_view(),name='comment-reply-update-api'),
    path('delete/<str:id>/',CommentDeleteAPIView.as_view(),name='comment-reply-delete-api'),
]