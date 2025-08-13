import random
import argparse
import pyjokes
from flask import Flask, Response

app = Flask(__name__)


@app.route('/', methods = ['GET'])
def get_sentence():
  joke = pyjokes.get_joke(language = 'en', category = 'neutral')
  return 'One line joke : ' + joke + '\n', 200

@app.route('/chuck', methods = ['GET'])
def get_sentence_chuck():
  joke = pyjokes.get_joke(language = 'en', category = 'chuck')
  return joke + '\n', 200

@app.route('/healthz', methods = ['GET'])
def health():
  return Response("Okay" + '\n', status = 200)

@app.route('/healthznotalive', methods = ['GET'])
def healthdead():
  return Response("NOTALIVE" + '\n', status = 503)

if __name__ == '__main__':
  app.run(host = '0.0.0.0', port = 5000)
