FROM ubuntu:16.04
MAINTAINER Foo-x akira_

RUN apt-get update && apt-get install -y curl build-essential python2.7 python git cmake \
    && cd /usr/local && curl -sL https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz | tar xz \
    && /bin/bash -c ". /usr/local/emsdk-portable/emsdk_env.sh && emsdk update && emsdk install -j1 sdk-incoming-64bit && emsdk activate sdk-incoming-64bit" \
    && curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly -y

ENV PATH=/root/.cargo/bin:/usr/local/emsdk-portable:/usr/local/emsdk-portable/clang/fastcomp/build_incoming_64/bin:/usr/local/emsdk-portable/node/4.1.1_64bit/bin:/usr/local/emsdk-portable/emscripten/incoming:${PATH} \
    EMSCRIPTEN=/usr/local/emsdk-portable/emscripten/incoming

RUN rustup toolchain add nightly \
    && rustup target add asmjs-unknown-emscripten --toolchain nightly \
    && rustup target add wasm32-unknown-emscripten --toolchain nightly \
    && apt-get autoclean && apt-get clean \
    && echo 'fn main() { println!("test"); }' > /tmp/test.rs \
    && rustc --target wasm32-unknown-emscripten /tmp/test.rs -o /tmp/test.html \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/local/emsdk-portable/zips /usr/local/emsdk-portable/clang/fastcomp/src

VOLUME ["/source"]
WORKDIR /source

CMD ["rustc", "-h"]