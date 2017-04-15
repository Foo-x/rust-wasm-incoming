# rust-wasm-incoming
## 1. Build
1. Create docker-machine
    1. `$ docker-machine create -d virtualbox --virtualbox-memory=4096 --virtualbox-cpu-count=2 --virtualbox-disk-size=50000 rust-wasm`

2. Build
    1. `$ cd /path/to/rust-wasm-incoming`
    2. `$ docker build -t foo .`  
    It takes some time and the size of the image is about 26GB.

## 2. Usage
### WebAssembly
``$ docker run -it -v `pwd`:/source foo rustc -O --target wasm32-unknown-emscripten bar.rs -o bar.html``

### asm.js
``$ docker run -it -v `pwd`:/source foo rustc -O --target asmjs-unknown-emscripten bar.rs -o bar.html``
