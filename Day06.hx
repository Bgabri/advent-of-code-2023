using StringTools;
// haxe --interp --main Day06.hx

class Day06 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/06.txt")));
        trace("solution to part 2: " + part2(loadPart2("inputs/06.txt")));    
    }

    static function part1(input:Array<Array<Int>>):Int {
        var total = 1;
        var i  = 0;
        for (time in input[0]) {
            var sum = 0;
            for (speed in 0...time) {
                var dist = (time-speed)*speed;
                if (dist > input[1][i]) sum++;
            }

            if (sum != 0) total *= sum;
            i ++ ;
        }
        return total;
    }
    static function part2(input:Array<Float>):Int {    
        var time = input[0];
        var tdist = input[1];

        var disc = Math.sqrt(time*time - 4*tdist);
        var t1 = Std.int((-time + disc)/-2);
        var t2 = Std.int((-time - disc)/-2);

        return t2-t1;
    }

    static function loadPart2(file:String):Array<Float> {
        var input:Array<Float> = [];
        var iterator = sys.io.File.read(file, false);
        while (!iterator.eof()){
            var line = iterator.readLine();
            line = line.replace(" ", "");

            var alpha:EReg = ~/:/;

            alpha.match(line);
            line = alpha.matchedRight();
            input.push(Std.parseFloat(line));
        }
        
        iterator.close();
        return input;
    }

    static function loadFile(file:String):Array<Array<Int>> {
        var input:Array<Array<Int>> = [];
        var iterator = sys.io.File.read(file, false);
        
        while (!iterator.eof()){
            var line = iterator.readLine();

            var alpha:EReg = ~/[0-9]+/;
            var matches = [];
            while (alpha.match(line)) {
                matches.push(alpha.matched(0));
                line = alpha.matchedRight();
            }

            var inp2:Array<Int> = matches.map(v -> Std.parseInt(v));
            input.push(inp2);
        }

        iterator.close();
        return input;
    }
}