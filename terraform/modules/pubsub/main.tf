# dagをトリガーするpubsub
# subscribed by composer
resource "google_pubsub_topic" "dag-topic-trigger" {
  name = "dag-topic-trigger"
}
