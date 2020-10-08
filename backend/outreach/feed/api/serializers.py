from rest_framework import serializers 

from ..models import Feed
from user.models import Profile
from user.api.serializers import ProfileSerializer

class FeedSerializer(serializers.ModelSerializer):
    creator = ProfileSerializer()
    class Meta:
        model = Feed
        fields = '__all__'

    def create(self,validated_data):
        title = validated_data['title']
        content = validated_data['content']
        imageUrl = validated_data['imageUrl']
        videoUrl = validated_data['videoUrl']
        creator_data = validated_data['creator']

        creator = Profile.objects.filter(user=creator_data['user']).first()

        feed = Feed(
            title=title,
            content=content,
            imageUrl=imageUrl,
            videoUrl=videoUrl,
            creator=creator,
        )

        feed.save()

        return validated_data
        