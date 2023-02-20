.DEFAULT_GOAL := build-all

export GO15VENDOREXPERIMENT=1

build-all: codis-server codis-dashboard codis-proxy codis-admin codis-ha codis-fe clean-gotest

codis-deps:
	mkdir -p bin config && bash version

codis-dashboard: codis-deps
	go build -o bin/codis-dashboard ./cmd/dashboard
	./bin/codis-dashboard --default-config > config/dashboard.toml

codis-proxy: codis-deps
	#go build -tags "cgo_jemalloc" -o bin/codis-proxy ./cmd/proxy
	go build -o bin/codis-proxy ./cmd/proxy
	./bin/codis-proxy --default-config > config/proxy.toml

codis-admin: codis-deps
	go build -o bin/codis-admin ./cmd/admin

codis-ha: codis-deps
	go build -o bin/codis-ha ./cmd/ha

codis-fe: codis-deps
	go build -o bin/codis-fe ./cmd/fe
	rm -rf bin/assets; cp -rf cmd/fe/assets bin/

codis-server:
	mkdir -p bin
	rm -f bin/codis-server*
	cd extern/redis/ && make distclean && make && cd -
	cp -f extern/redis/src/redis-server  bin/codis-server
	cp -f extern/redis/src/redis-benchmark bin/
	cp -f extern/redis/src/redis-cli bin/
	cp -f extern/redis/src/redis-sentinel bin/
	cp -f extern/redis/redis.conf config/
	sed -e "s/^sentinel/# sentinel/g" extern/redis/sentinel.conf > config/sentinel.conf

clean-gotest:
	rm -rf ./pkg/topom/gotest.tmp

clean:
	cd example && make clean && cd -
	rm -rf bin rootfs
	rm -rf scripts/tmp

gotest: codis-deps
	go test ./cmd/... ./pkg/...

gobench: codis-deps
	go test -gcflags -l -bench=. -v ./pkg/...

docker:
	docker build --force-rm -t codis-image .

demo:
	pushd example && make
