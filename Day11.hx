using StringTools;
// haxe --interp --main Day11.hx

class Day11 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/11.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/11.txt")));    
    }


    static function expand(input:Array<String>):Array<String> {
        var newInput:Array<String> = [];
        for (line in input) {
            if (!~/#/.match(line)) {
                newInput.push(line);
            }
            newInput.push(line);
        }

        var newerInput:Array<String> = [];

        for (y in 0...newInput.length) newerInput.push("");

        for (x in 0...newInput[0].length) {
            var empty = true;
            for (line in newInput) {
                if (line.charAt(x) == "#") {
                    empty = false;
                    break;
                }
            }

            for (y in 0...newInput.length) {
                newerInput[y] += newInput[y].charAt(x);
                if (empty) newerInput[y] += ".";
            }
        }
        return newerInput;

    }

    static function part1(input:Array<String>):Int {
        var input = expand(input);
        var total = 0;

        var gasls:Array<{x:Int, y:Int}> = [];
        for (y in 0...input.length) {
            for (x in 0...input[y].length) {
                if (input[y].charAt(x) == "#") {
                    gasls.push({x:x, y:y});
                }
            }
        }
        
        for (i in 0...gasls.length) {
            var g1 = gasls[i];
            for (j in i+1...gasls.length) {
                var g2 = gasls[j];

                var l = Std.int(Math.abs(g1.x-g2.x) + Math.abs(g1.y-g2.y));
                total += l;

            }
        }

        return total;
    }

    static function expand2(input:Array<String>):Array<Array<Int>> {
        var newInput:Array<Array<Int>> = [[],[]];
        for (line in input) {
            if (!~/#/.match(line)) newInput[1].push(1000000);
            else newInput[1].push(1);
        }


        for (x in 0...input[0].length) {
            var empty = true;
            for (line in input) {
                empty = false;
                if (line.charAt(x) == "#") break;
                empty = true;
            }

            if (empty) newInput[0].push(1000000);
            else newInput[0].push(1);
        }
        return newInput;

    }

    static function part2(input:Array<String>):Float {
        var expansion = expand2(input);
        var total = 0.;

        var gasls:Array<{x:Int, y:Int}> = [];
        for (y in 0...input.length) {
            for (x in 0...input[y].length) {
                if (input[y].charAt(x) == "#") {
                    gasls.push({x:x, y:y});
                }
            }
        }
        
        for (i in 0...gasls.length) {
            var g1 = gasls[i];
            for (j in i+1...gasls.length) {
                var g2 = gasls[j];

                var l = 0.;
                
                var x0 = g1.x;
                var xn = g2.x;

                if (xn < x0) {
                    x0 = g2.x;
                    xn = g1.x;
                }

                for (x in x0...xn) {
                    l += expansion[0][x];
                }
                for (y in g1.y...g2.y) {
                    l += expansion[1][y];
                }
                total += l;

            }
        }

        return total;
    }
    
    static function loadFile(file:String):Array<String> {
        var input:Array<String> = [];
        var iterator = sys.io.File.read(file, false);
        
        while (!iterator.eof()){
            var line = iterator.readLine();
            input.push(line);
        }
        iterator.close();
        return input;
    }
}