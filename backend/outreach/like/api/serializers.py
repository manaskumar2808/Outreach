from rest_framework import serializers

from ..models import Like
from user.models import Profile
from feed.models import Feed
from user.api.serializers import ProfileSerializer

class LikeSerializer(serializers.ModelSerializer):
    liker  = ProfileSerializer()
    class Meta:
        model=Like
        fields='__all__'
    
    def create(self,validated_data):
        parent = validated_data['parent']
        liker_data = validated_data['liker']

        liker = Profile.objects.filter(user=liker_data['user']).first()

        if parent == 'feed':
            feed = validated_data['feed']
            like = Like(
                parent = parent,
                liker = liker,
                feed = feed,
            )
        elif parent == 'comment': 
            comment = validated_data['comment']
            like = Like(
                parent = parent,
                liker = liker,
                comment = comment,
            )

        like.save()
        return validated_data