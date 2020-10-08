from rest_framework import serializers

from ..models import Save
from user.models import Profile
from feed.models import Feed
from user.api.serializers import ProfileSerializer
from feed.api.serializers import FeedSerializer

class SaveSerializer(serializers.ModelSerializer):
    feed = FeedSerializer()
    saver  = ProfileSerializer()
    class Meta:
        model=Save
        fields='__all__'
    
    def create(self,validated_data):
        parent = validated_data['parent']
        saver_data = validated_data['saver']
        feed_data = validated_data['feed']

        saver = Profile.objects.filter(user=saver_data['user']).first()
        feed = Feed.objects.filter(title=feed_data['title'], content=feed_data['content']).first()

        save = Save(
            parent = parent,
            saver = saver,
            feed = feed,
        )
        save.save()
        return validated_data