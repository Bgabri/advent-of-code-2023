using StringTools;
// haxe --interp --main DayXX.hx

class DayXX {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/XX.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/XX.txt")));    
    }

    static function part1(input:Array<String>):Int {
        trace(input);
        for (line in input) {

        }
        return 0;
    }
    static function part2(input:Array<String>):Int {
        return 0;
        for (line in input) {
            
        }
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