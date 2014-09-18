#
# BUILD THEME
#

OUTPUT_PATH = build
BOOTSTRAP_PATH = bootstrap

theme:
	-test -d ${OUTPUT_PATH} && rm -r ${OUTPUT_PATH}
	mkdir ${OUTPUT_PATH}
	which recess || npm install recess -g
	-test -d ${BOOTSTRAP_PATH} || make bootstrap
	recess --compile merged.less > ${OUTPUT_PATH}/bootstrap.css
	recess --compress merged.less > ${OUTPUT_PATH}/bootstrap.min.css
	recess --compile merged-responsive.less > ${OUTPUT_PATH}/bootstrap-responsive.css
	recess --compress merged-responsive.less > ${OUTPUT_PATH}/bootstrap-responsive.min.css

bootstrap:
	-test -d ${BOOTSTRAP_PATH} && rm -r ${BOOTSTRAP_PATH}
	curl --location -o bootstrap-2.x.tar.gz https://github.com/twbs/bootstrap/archive/v2.3.2.tar.gz
	tar -xzf bootstrap-2.x.tar.gz
	rm bootstrap-2.x.tar.gz
	mv bootstrap-* ${BOOTSTRAP_PATH}

default:
	make theme

watcher:
	ruby watcher.rb

server:
	open http://localhost:8000/test/test.html
	python -m SimpleHTTPServer

.PHONY: theme bootstrap default watcher server