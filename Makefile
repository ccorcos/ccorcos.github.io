install:
	bundle install
	npm install

run:
	bundle exec jekyll serve

compress:
	./node_modules/.bin/gulp compress
