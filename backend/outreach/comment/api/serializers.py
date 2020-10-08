from rest_framework import serializers

from ..models import Comment, Reply
from user.models import Profile
from feed.models import Feed
from user.api.serializers import ProfileSerializer

class CommentSerializer(serializers.ModelSerializer):
    commentor = ProfileSerializer()
    class Meta:
        model=Comment
        fields='__all__'
    
    def create(self,validated_data):
        text = validated_data['text']
        status = validated_data['status']
        commentor_data = validated_data['commentor']
        feed = validated_data['feed']

        commentor = Profile.objects.filter(user=commentor_data['user']).first()
        # feed = Feed.objects.get(feed_data['id'])

        comment = Comment(
            text=text,
            status=status,
            commentor=commentor,
            feed=feed,
        )

        comment.save()

        return validated_data


class ReplySerializer(serializers.ModelSerializer):
    replier = ProfileSerializer()
    class Meta: 
        model=Reply
        fields='__all__'
    
    def create(self,validated_data):
        text = validated_data['text']
        replier_data = validated_data['replier']
        comment = validated_data['comment']

        replier = Profile.objects.filter(user=replier_data['user']).first()

        reply = Reply(
            text=text,
            replier=replier,
            comment=comment,
        )

        reply.save()

        return validated_data