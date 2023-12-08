import haxe.Int64;
using StringTools;
// haxe --interp --main Day08.hx

class Day08 {

    static var instructions:String;

    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/08.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/08.txt")));    
    }

    static function findNode(node:String, input:Array<Array<String>>):Int {
        var i = 0;
        for (dir in input) {
            if (dir[0] == node) return i;
            i++;
        }
        trace("something went wrong");
        return -1;
    }
    static function part1(input:Array<Array<String>>):Int {
        var end = findNode("ZZZ", input);
        var node = findNode("AAA", input);

        var l = instructions.length;
        var i = 0;
        while (node != end) {
            var n = input[node];
            var ins = instructions.charAt(i%l);
            if (ins == "R") node = findNode(n[2], input);
            else if (ins == "L") node = findNode(n[1], input);
            i++;
        }
        return i;
    }

    
    static function findNodes(node:String, input:Array<Array<String>>):Array<Int> {
        var i = 0;
        
        var nodes:Array<Int> = [];
        for (dir in input) {
            if (dir[0].charAt(2) == node) nodes.push(i);
            i++;
        }
        return nodes;
    }

    static function end(nodes:Array<Int>, input:Array<Array<String>>):Bool {
        for (node in nodes) {
            if (input[node][0].charAt(2) != "Z") return false;
        }
        return true;
    }

    static function gcd(a:Float, b:Float) {
        if (b == 0) return a;
        return gcd(b, a%b);
    }

    static function lcm(nums:Array<Int>):Float {
        var lcm:Float = nums[0];
        for (i in 1...nums.length) {
            var num = nums[i];
            lcm = (lcm*num)/gcd(lcm, num);
        }
        return lcm;
    }

    static function part2(input:Array<Array<String>>):Float {
        var l = instructions.length;
        var steps:Array<Int> = [];
        
        var nodes = findNodes("A", input);
        
        for (cnode in nodes){   
            var node = findNode(input[cnode][0], input);
            var i = 0;
            while (input[node][0].charAt(2) != "Z") {
                var n = input[node];
                var ins = instructions.charAt(i%l);
                if (ins == "R") node = findNode(n[2], input);
                else if (ins == "L") node = findNode(n[1], input);
                i++;
            }
            steps.push(i);
        }

        return lcm(steps);
    }


    static function loadFile(file:String):Array<Array<String>> {
        var input:Array<Array<String>> = [];
        var iterator = sys.io.File.read(file, false);

        instructions = iterator.readLine();
        
        iterator.readLine();
        while (!iterator.eof()){
            var line = iterator.readLine();
            line = line.replace(" = ", ", ");
            line = line.replace("(", "");
            line = line.replace(")", "");
            var inp = line.split(", ");
            input.push(inp);
        }
        iterator.close();
        return input;
    }
}