from enum import Enum
from lib.const import IS_DEV


class SlackConfig:
    class Channel(Enum):
        DEV_NOTIFICATION = "AAAAAAA"

    @staticmethod
    def get_channel(channel: Channel):
        if IS_DEV:
            return SlackConfig.Channel.DEV_NOTIFICATION.value
        return channel.value
