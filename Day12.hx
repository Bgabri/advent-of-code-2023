import haxe.io.Input;
using StringTools;
// haxe --interp --main Day12.hx

class Day12 {

    static var groups:Array<Array<Int>> = [];
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/12.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/12.txt")));    
    }


    static function valid(inp:String, group:Array<Int>):Bool {

        var length = 0;
        var i = 0;
        for (char in inp) {
            if (char == '#'.code) length++;
            else {
                if (length != 0) {
                    if (group[i] != length) return false;
                    i++;
                }
                length = 0;
            }
        }

        if (length != 0) {
            if (group[i] != length) return false;
            i++;
        }

        return group.length == i;
    }

    static var max = 0;

    static function arrangments(inp:String, group:Array<Int>):Int {

        var length = 0;

        for (char in inp) {
            if (char == '?'.code) length ++;
        }
        if (length > max) max = length;

        var total = 0;

        var max = 1<<length;
        for (i in 0...max) {
            var newInput = "";
            var tmp = i;
            for (code in inp) {
                var char = String.fromCharCode(code);
                if (char == '?') {
                    if (tmp&1 == 1) char = "#";
                    else char = ".";
                    tmp = tmp>>1;
                }
                newInput += char;
            }
            if (valid(newInput, group)) {
                total++;
                // trace(newInput);
            }
        }
        
        
        return total;
    }

    static function replaceSub(s:String, sub:String, index:Int):String {
        var newString = "";
        for (i in 0...index) newString += s.charAt(i);
        for (c in sub) newString += String.fromCharCode(c);
        for (i in index+sub.length...s.length) newString += s.charAt(i);
        return newString;
    }

    static function part1(input:Array<String>):Int {
        var total = 0;
        for (x in 0...input.length) {
            var num = arrangments(input[x], groups[x]); 
            total += num;
            trace('$x $num');
        }

        return total;
    }
    static function part2(input:Array<String>):Int {
        var newInput:Array<String> = [];
        var newGroups:Array<Array<Int>> = [];
        var i = 0;
        for (line in input) {
            var newLine = line;
            var group = groups[i];
            var newGroup:Array<Int> = [];
            // for (g in group) newGroup.push(g);
            newGroup = newGroup.concat(group);
            for (i in 0...4) {
                newGroup = newGroup.concat(group);
                newLine += "?" + line;
            }
            newInput.push(newLine);
            newGroups.push(newGroup);
            i++;
        }

        groups = newGroups;

        return part1(newInput);
    }

    static function loadFile(file:String):Array<String> {
        var input:Array<String> = [];
        var iterator = sys.io.File.read(file, false);
        groups = [];
        
        while (!iterator.eof()){
            var line = iterator.readLine();
            var aaa = line.split(" ");
            var inp = aaa[1].split(",");
            var inp2:Array<Int> = inp.map(v -> Std.parseInt(v));
            groups.push(inp2);
            input.push(aaa[0]);
        }
        iterator.close();
        return input;
    }
}