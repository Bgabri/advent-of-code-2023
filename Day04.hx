import sys.ssl.Socket;
using StringTools;
// haxe --interp --main Day04.hx

class Day04 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/04.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/04.txt")));    
    }

    static function part1(input:Array<String>):Int {
        var sum = 0;
        for (line in input) {
            var epsilon = ~/Card[\s0-9]+:\s/;
            epsilon.match(line);
            line = epsilon.matchedRight();

            var bar = line.split(" | ");
            var wining = bar[0]; 
            var nums = bar[1];
            var wining = wining.split(" "); 
            var nums = nums.split(" "); 
            
            var score = 0;
            for (num in wining) {
                if (num == "") continue;
                for (num2 in nums) {
                    if (num2 == "") continue;
                    if (num2 == num) {
                        if (score == 0) score = 1;
                        else score <<= 1;
                    }
                }
            }
            sum += score;

        }
        return sum;
    }

    static function calcScore(line:String):Int {
        var epsilon = ~/Card[\s0-9]+:\s/;
        epsilon.match(line);
        line = epsilon.matchedRight();

        var bar = line.split(" | ");
        var wining = bar[0]; 
        var nums = bar[1];
        var wining = wining.split(" "); 
        var nums = nums.split(" "); 
        
        var score = 0;
            for (num in wining) {
                if (num == "") continue;
                for (num2 in nums) {
                    if (num2 == "") continue;
                    if (num2 == num) {
                        if (score == 0) score = 1;
                        else score <<= 1;
                    }
                }
            }
        return score;

    }

    static function part2(input:Array<String>):Int {
        var sum = 0;
        var rewards:Array<Int> = [];
        
        for (line in input) rewards.push(1);

        for (line in input) {
            var cards = rewards[0];
            var score = calcScore(line);
            sum += cards;
            trace('$score, $cards');
            rewards.shift();
            var i = 0;
            while (score > 0) {
                rewards[i] += cards;
                score >>= 1;
                i ++;
            }
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