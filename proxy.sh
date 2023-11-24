function set_proxy() {
    ip="127.0.0.1"
    port="7890"
    if [ $1 ]; then
       ip=$1
    fi

    if [ $2 ]; then 
       port=$2
    fi
    http="http://$ip:$port"
    https="https://$ip:$port"
    export http_proxy=$http
    export https_proxy=$https
    export http=$http
    export https=$https
    export all_proxy=$http
    git config --global http.proxy $http
    git config --global https.proxy $https
    echo -e "Proxy on: $ip:$port."
}

function unset_proxy(){
    unset http_proxy https_proxy http https all_proxy
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    echo -e "Proxy off."
}


function test_proxy(){
    echo "Http proxy:" ${http}
    echo "Https proxy:" ${https}
    echo "Try to connect to Google..."

    resp=$(curl -I -s --connect-timeout 5 -m 5 -w "%{http_code}" -o /dev/null www.google.com)
    if [ ${resp} = 200 ]; then
        echo "Proxy setup succeeded!"
    else
        echo "Proxy setup failed!"
    fi
}
