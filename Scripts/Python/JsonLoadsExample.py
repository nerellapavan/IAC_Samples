import json

# you can also use the open function to read the content of a JSON file to a string
json_data = {
    "key 1": "value 1",
    "key 2": "value 2",
    "decimal": 10,
    "boolean": true,
    "list": [1, 2, 3],
    "dictionary": {
        "child key 1": "child value",
        "child key 1": "child value"
    }
}

my_dict = json.loads(json_data)