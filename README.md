# Mini Indexer

### Create mini-indexer index:

```
PUT /course_offers
{
  "mappings": {
    "properties": {
      "offer_id": {
        "type": "integer"
      },
      "name": {
        "type": "text",
        "fields": {
          "brazilian": {
            "type": "search_as_you_type",
            "analyzer": "brazilian"
          }
        }
      },
      "level": {
        "type": "text"
      },
      "kind": {
        "type": "text"
      },
      "shift": {
        "type": "text"
      },
      "full_price": {
        "type": "float"
      },
      "max_payments": {
        "type": "integer"
      },
      "enrollment_semester": {
        "type": "keyword"
      },
      "discount_percentage": {
        "type": "float"
      }
    }
  }
}
```