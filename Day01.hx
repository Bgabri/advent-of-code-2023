using StringTools;
// haxe --interp --main Dayxx.hx

class Day01 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/01.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/01.txt")));    
    }

    static function part1(input:Array<String>):Int {
        var sum = 0;
        for (string in input) {
            var alpha:EReg = ~/[0-9]/;
            var matches = [];
            while (alpha.match(string)) {
                // string = alpha.replace(string, "");
                matches.push(alpha.matched(0));
                string = alpha.matchedRight();
            }
            var newS = alpha.replace(string, "");
            sum += Std.parseInt(matches[0])*10;
            sum += Std.parseInt(matches[matches.length-1]);

        }
        return sum;
    }

    static  function matchInt(sInt:String):Int {

        return switch (sInt){
            case "one":   1;
            case "two":   2;
            case "three": 3;
            case "four":  4;
            case "five":  5;
            case "six":   6;
            case "seven": 7;
            case "eight": 8;
            case "nine":  9;
            default: Std.parseInt(sInt);
        }
        
    }
    static function part2(input:Array<String>):Int {
        var sum = 0;
        for (string in input) {
            var alpha:EReg = ~/[0-9]|(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)/;
            var matches = [];
            while (alpha.match(string)) {
                matches.push(alpha.matched(0));
                string = string.substr(1);
            }
            sum += matchInt(matches[0])*10;
            sum += matchInt(matches[matches.length-1]);

        }
        return sum;
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