using StringTools;
// haxe --interp --main Day02.hx

class Day02 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/02.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/02.txt")));    
    }

    static function part1(input:Array<String>):Int {
        var i = 0;
        var sum = 0;
        for (line in input){
            line = line.replace(",", ",");
            line = line.replace(";", ",");
            line = line.replace("red", "r");
            line = line.replace("green", "g");
            line = line.replace("blue", "b");

            var alpha:EReg = ~/Game [0-9]*:\s/;


            // line = line.substring(8+ Std.int((i+1)/10));
            alpha.match(line);
            line = alpha.matchedRight();

            var red = 0;
            var green = 0;
            var blue = 0;
            var colours = line.split(", ");

            var valid = true;
            for (colour in colours) {
                var c = colour.charAt(colour.length-1);
                var n = Std.parseInt(colour.substr(0, colour.length-1));
                switch(c) {
                    case "r": if (n > 12)valid = false;
                    case "g": if (n > 13)valid = false;
                    case "b": if (n > 14)valid = false;
                }
            }

            i += 1;
            if (valid) {
                sum += i;
            }

        }
        return sum;
    }
    static function part2(input:Array<String>):Int {
        var i = 0;
        var sum = 0;
        for (line in input){
            line = line.replace(",", ",");
            line = line.replace("red", "r");
            line = line.replace("green", "g");
            line = line.replace("blue", "b");

            var alpha:EReg = ~/Game [0-9]*:\s/;

            alpha.match(line);
            line = alpha.matchedRight();

            var maxR = 0;
            var maxG = 0;
            var maxB = 0;
            var rounds = line.split("; ");
            for (round in rounds) {
                var colours = round.split(", ");
    
                var valid = true;
                for (colour in colours) {
                    var c = colour.charAt(colour.length-1);
                    var n = Std.parseInt(colour.substr(0, colour.length-1));
                    switch(c) {
                        case "r": if (n > maxR)  maxR = n;
                        case "g": if (n > maxG)  maxG = n;
                        case "b": if (n > maxB)  maxB = n;
                    }
                }
            }

            sum += maxR*maxG*maxB;

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