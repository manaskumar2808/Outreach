from rest_framework import serializers

from user.api.serializers import ProfileSerializer

from ..models import Follow
from user.models import Profile

class FollowSerializer(serializers.ModelSerializer):
    follower = ProfileSerializer()
    followed = ProfileSerializer()
    class Meta:
        model = Follow
        fields = '__all__'
    
    def create(self,validated_data):
        follower_data = validated_data['follower']
        followed_data = validated_data['followed']

        follower = Profile.objects.filter(user=follower_data['user']).first()
        followed = Profile.objects.filter(user=followed_data['user']).first()

        follow = Follow(
            follower = follower,
            followed = followed,
        )

        follow.save()
        return validated_data