using StringTools;
// haxe --interp --main Day03.hx

class Day03 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/03.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/03.txt")));    
    }


    static function isNum(char:Int):Bool {
        return "0".code <= char && char <= "9".code;
    }

    static function checkNumInEngine(x:Int, len:Int, y:Int, input:Array<String>):Bool {
        for (yPos in y-1...y+2) {
            if (yPos < 0 || yPos >= input.length) continue;
            var line = input[yPos];
            for (xPos in x-1...x+len+1) {
                if (xPos < 0 || xPos >= line.length) continue;

                var c = line.charAt(xPos);
                if (c != "." && !isNum(c.charCodeAt(0))) return true;
            }
        }

        return false;
    }

    static function part1(input:Array<String>):Int {
        var sum = 0;
        var y = 0;
        for (line in input) {
            var epsilon:EReg = ~/[0-9]+/;
            var xPos = 0;
            while (epsilon.match(line)) {

                var match = epsilon.matched(0);
                var pos = epsilon.matchedPos();

                var isIn = checkNumInEngine(pos.pos+xPos, pos.len, y, input);
                if (isIn) sum += Std.parseInt(match);

                line = epsilon.matchedRight();
                xPos += match.length + pos.pos;
            }
            y++;
        }
        return sum;
    }


    static function matchNum(x:Int, line:String):{pos:Int, len:Int} {
        var p = {pos: 0, len: 0};
        var c = line.charCodeAt(x);
        if (!("0".code <= c && c <= "9".code)) return p;
           

        while (x > -1 && isNum(c)) {
            x--;
            c = line.charCodeAt(x);
        }
        x++;
        p.pos = x;

        var len = 0;
        var c = line.charCodeAt(x+len);
        while (x + len < line.length && isNum(c)) {
            len++;
            c = line.charCodeAt(x+len);
        }
        p.len = len;

        return p;
    }

    static function findGearRatio(x:Int, y:Int, input:Array<String>):Int {
        var ratio = 1;
        var nums = 0;
        for (yPos in y-1...y+2) {
            if ( yPos < 0 || yPos >= input.length) continue;

            var line = input[yPos];
            var xPos = x-1;
            while (xPos < x+2) {
                var c = line.charCodeAt(xPos);
                var p = matchNum(xPos, line);
                if (p.len > 0) {
                    ratio *= Std.parseInt(line.substr(p.pos, p.len));
                    nums++;
                    xPos = p.pos + p.len;
                }
                xPos++;
            }

        }
        if (nums < 2) return 0;
        return ratio;
    }

    static function part2(input:Array<String>):Int {
        var sum = 0;
        var y = 0;
        
        for (line in input) {
            var x = 0;
            for (char in line) {
                if (char == "*".code) {
                    var r = findGearRatio(x, y, input);
                    sum += r;
                }
                x++;
            }
            y++;
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