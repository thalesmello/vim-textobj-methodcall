var variable = 1;

function foo () {
    logger(function () {
        var array = [1, 2, 3, 4, 5];

        array.map(function (x) { return x * 2; })
            .filter(function (x) { return x != 4; })
            .forEach(function (x) {
                return console.log(x);
            });
    });

    function logger (block) {
        console.log("begin");

        block();
    }
}

function bar () {
    console.log('Good bye bar!');
}

foo();
