import haxe.display.Position.Range;
using StringTools;
// haxe --interp --main Day05.hx

class Day05 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/05.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/05.txt")));    
    }

    static function part1(input:Array<String>):Float {
        
        var seeds:Array<Float> = input[0].substr(7).split(" ").map(v -> Std.parseFloat(v));
        
        var i = 3;
        var maped:Array<Bool> = [];
        while (i < input.length) {
            var line = input[i];
            if (line == "") {
                i += 2;
                maped = [];
                continue;
            }
            
            var map:Array<Float> = line.split(" ").map(v -> Std.parseFloat(v));
            var j = 0;
            for (seed in seeds) {
                
                if (map[1] <= seed && seed < map[1] + map[2] && !maped[j]) {
                    maped[j] = true;
                    seeds[j] = map[0] - map[1] + seed;
                }
                j++;
            }
            i++;
        }

        var small:Float = 1<<30;
        for (seed in seeds) {
            if (seed < small) small = seed;
        }
        return small;
    }


    static function part2(input:Array<String>):Float {
        var seeds:Array<Float> = input[0].substr(7).split(" ").map(v -> Std.parseFloat(v)); 
        
        var i = 3;
        var startI = 3;
        while (i < input.length) {
            var newSeeds:Array<Float> = [];

            while (seeds.length > 0) {
                var length = seeds.pop();
                var seed = seeds.pop();
                
                var line = input[i];
                var j = 0;
                
                while (line != "" && i+j < input.length) {
                    // trace('$seed, $line');
                    var map:Array<Float> = line.split(" ").map(v -> Std.parseFloat(v));

                    if (map[1] <= seed && seed < map[1] + map[2]) {
                        if (seed + length > map[1] + map[2]) { //length not in range                        
                            // trace("ASdasdasdasd");
                            var newSeed = map[1] + map[2];
                            // var newLength = seeds[j+1] - (map[2] - (map[1]-map[0]));
                            var newLength = seed + length - (map[1] + map[2]);

                            seeds.push(newSeed);
                            seeds.push(newLength);
                            
                            length = map[1] + map[2] - seed;
                        }
                        seed = map[0] - map[1] + seed;
                        break;
                    }
                    j++;
                    line = input[i+j];
                }
                newSeeds.push(seed);
                newSeeds.push(length);
            }
            
            for (newSeed in newSeeds) {
                seeds.push(newSeed);
            }

            var line = input[i];
            while (line != "" && i < input.length) {
                i++;
                line = input[i];
            }
            i += 2;

        }
        
        var small:Float = 1<<30;
        var j = 0;
        while (j < seeds.length) {
            if (seeds[j] < small) small = seeds[j];
            j += 2;
        }
        return small;
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