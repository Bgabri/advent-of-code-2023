import haxe.macro.Tools.TPositionTools;
using StringTools;
// haxe --interp --main Day09.hx

class Day09 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/09.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/09.txt")));    
    }

    static function equal(list:Array<Int>):Bool {
        var num = list[0];
        for (n in list) {
            if (n != num) return false;
        }
        return true;
    }
    static  function copy(list:Array<Int>):Array<Int> {
        var newList:Array<Int> = [];
        for (n in list) newList.push(n);
        return newList;
    }

    static function part1(input:Array<Array<Int>>):Int {
        var total = 0;
        for (line in input) {
            var depth = 0;
            var diff:Array<Int> = copy(line);
            
            var latsDigs:Array<Int> = [];
            latsDigs.push(line[line.length-1]);

            while (!equal(diff)) {
                var newList:Array<Int> = [];
            
                for (i in 1...diff.length) {
                    newList.push(diff[i] - diff[i-1]);
                }
                
                diff = copy(newList);
                latsDigs.push(diff[diff.length-1]);
                depth++;
            }

            var next = latsDigs[0];

            for (i in 1...depth+1) {
                next += latsDigs[i];
            }
            total += next;

        }

        return total;
    }

    static function part2(input:Array<Array<Int>>):Int {
        var total = 0;
        for (line in input) {
            var depth = 0;
            var diff:Array<Int> = copy(line);
            
            var firstDigs:Array<Int> = [];
            firstDigs.push(line[0]);
            while (!equal(diff)) {
                var newList:Array<Int> = [];
            
                for (i in 1...diff.length) {
                    newList.push(diff[i] - diff[i-1]);
                }
                
                diff = copy(newList);
                firstDigs.push(diff[0]);
                depth++;
            }

            var next = firstDigs[depth];

            for (i in 1...depth+1) {
                next = firstDigs[depth-i] - next;
            }
            total += next;

        }

        return total;
    }

    static function loadFile(file:String):Array<Array<Int>> {
        var input:Array<Array<Int>> = [];
        var iterator = sys.io.File.read(file, false);
        
        while (!iterator.eof()){
            var line = iterator.readLine();
            var inp = line.split(" ");
            var inp2:Array<Int> = inp.map(v -> Std.parseInt(v));
            input.push(inp2);
        }
        iterator.close();
        return input;
    }
}