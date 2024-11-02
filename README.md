# Mini Indexer

### Create mini-indexer index:

```
PUT /course_offers
{
  "mappings": {
    "properties": {
      "object_id": {
        "type": "integer"
      },
      "course_name": {
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