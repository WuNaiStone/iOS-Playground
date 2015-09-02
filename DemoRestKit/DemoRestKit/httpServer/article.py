# -*- coding: utf-8 -*-

#!/usr/bin/python

from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def index():
	return 'index'

#使用<user>传递参数
@app.route('/hello/<user>')
def hello_get(user):
	return 'hello get %s' % user

#使用POST请求
@app.route('/hello/<user>', methods=['POST'])
def hello_post(user):
	return 'hello post %s' % user

@app.route('/json')
def hotCity():
	return jsonify({
				'article': {
					'title': 'My Article',
					'author': 'Blake',
					'body': 'Very cool!!'
				}
			})



if __name__ == '__main__':
	app.run()
