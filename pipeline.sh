votingappPath='./src/votingapp'
build(){
    pushd $votingappPath
    ./deps.sh
    rm -rf ./deploy
    (go build -o ./deploy/votingapp && cp -r ui ./deploy) || return 1
    popd
}

run(){
    app='votingapp'
    pushd $votingappPath
    pid=$(ps | grep votingapp | awk '{ print $1}' | head -1)
    kill -9 $pid || true
    ./deploy/$app &
    popd

}


if build  > log 2> error; then
    echo "Build completed"
    run
    if test; then
        echo "Test Passed"
    else
        echo "Test Failed"
    fi    
else
    echo "FAILED"
fi