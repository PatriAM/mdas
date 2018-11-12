import requests
import json
import unittest

def http_client(method, data={}):
    url = 'http://votingapp:8080/vote'

    if method == 'POST':
        response = requests.post(url, json=data)
    elif method == 'PUT':
        response = requests.put(url, json=data)
    elif method == 'DELETE':
        headers = {'Content-Type': 'application/json'}
        response = requests.delete(url, headers=headers)

    return response.json()

def test():
    http_client('POST', {"topics":["bash","python","go"]})
    options = ["bash", "go", "bash", "ruby", "python"]
    expected_winner = "bash"

    for option in options:
        t = {"topic": option}
        http_client('PUT', t)

    winner_response = http_client('DELETE')
    winner = winner_response["winner"]
    if winner == expected_winner:
        print("TEST RESULT: OK")
    else:
        print("TEST RESULT: Fail")

test()