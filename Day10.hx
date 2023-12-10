import haxe.zip.Tools;
using StringTools;
// haxe --interp --main Day10.hx

class Day10 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/10.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/10.txt")));    
    }

    static function findStart(input:Array<String>):{x:Int, y:Int} {

        for (y in 0...input.length) {
            for (x in 0...input.length) {
                if (input[y].charAt(x) == "S") return {x:x, y:y};
            }
        }
        return {x:-1, y:-1};
    }
    
    
    static function stepPipe(curr:{x:Int, y:Int}, prev:{x:Int, y:Int}, input:Array<String>) {
        var newPos = {x:curr.x, y:curr.y};        
        if (curr.y < 0 || curr.y >= input.length) return newPos;
        if (curr.x < 0 || curr.x >= input[curr.y].length) return newPos;
        var pipe = input[curr.y].charAt(curr.x);

        switch pipe {
            case "|":
                if (prev.x == curr.x) newPos.y += curr.y - prev.y;
            case "-":
                if (prev.y == curr.y) newPos.x += curr.x - prev.x;
            case "L":
                if (prev.x == curr.x && prev.y+1 == curr.y) newPos.x += 1; // top
                if (prev.x-1 == curr.x && prev.y == curr.y) newPos.y -= 1; // right
            case "J":
                if (prev.x == curr.x && prev.y+1 == curr.y) newPos.x -= 1; // top
                if (prev.x+1 == curr.x && prev.y == curr.y) newPos.y -= 1; // left
            case "7":
                if (prev.x == curr.x && prev.y-1 == curr.y) newPos.x -= 1; // bottom
                if (prev.x+1 == curr.x && prev.y == curr.y) newPos.y += 1; // left
            case "F":
                if (prev.x == curr.x && prev.y-1 == curr.y) newPos.x += 1; // bottom
                if (prev.x-1 == curr.x && prev.y == curr.y) newPos.y += 1; // left
            case ".":
            case _:
        }
        return newPos;
    }


    static function len(current:{x:Int, y:Int}, prev:{x:Int, y:Int}, input:Array<String>):Int {
        var l = 0;
        while (prev.x != current.x || prev.y != current.y) {
            var newPos = stepPipe(current, prev, input);
            prev = {x: current.x, y:current.y};
            current = {x: newPos.x, y:newPos.y};
            l += 1;
        }        
        return l;
    }

    static function part1(input:Array<String>):Int {
        var start = findStart(input);
        
        
        var prev = {x: start.x, y:start.y};
        var current = {x: start.x, y:start.y};
        current.y -= 1;
        var n = len(current, prev, input);


        var prev = {x: start.x, y:start.y};
        var current = {x: start.x, y:start.y};
        current.x += 1;
        var e = len(current, prev, input);


        var prev = {x: start.x, y:start.y};
        var current = {x: start.x, y:start.y};
        current.y += 1;
        var s = len(current, prev, input);


        var prev = {x: start.x, y:start.y};
        var current = {x: start.x, y:start.y};
        current.x -= 1;
        var w = len(current, prev, input);

        var max = n;
        if (e > max) max = e;
        if (s > max) max = s;
        if (w > max) max = w;

        return Std.int(max/2);
    }


    static function markLoop(current:{x:Int, y:Int}, prev:{x:Int, y:Int}, input:Array<String>, loop:Array<Array<Int>>):Int {
        var l = 0;
        while (prev.x != current.x || prev.y != current.y) {
            var newPos = stepPipe(current, prev, input);
            prev = {x: current.x, y:current.y};
            current = {x: newPos.x, y:newPos.y};
            l += 1;
            loop[current.y][current.x] = 2;
        }        
        return l;
    }

    static function enclosureSize(input:Array<String>, loop:Array<Array<Int>>) {
        var total = 0;
        for (y in 0...loop.length) {
            var inloop = false;
            for (x in 0...loop[y].length) {
                var n = loop[y][x];
                if (n == 2) {
                    var c = input[y].charAt(x);
                    if (c == "|" || c == "J"  || c == "L"  || c == "S" ) {
                        inloop = !inloop;
                    }
                } else if (inloop) total ++;
            }
        }
        return total;
        
    }

    static function part2(input:Array<String>):Int {
        var loop:Array<Array<Int>> = [];
        for (y in 0...input.length) {
            loop.push([]);
            for (x in 0...input[y].length) {
                var c = input[y].charAt(x);
                if (c == ".") loop[y].push(0);
                else loop[y].push(1);
            }
        }

        var start = findStart(input);
        var prev = {x: start.x, y:start.y};
        var current = {x: start.x, y:start.y};

        current.x += 1;

        var n = markLoop(current, prev, input, loop);

        return enclosureSize(input , loop);
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