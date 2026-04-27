public class Program {
    public static void Main(string[] args) {
        while (true) {
            String line = Console.ReadLine();
            if (line == null) {
                break;
            }

            line = line.Trim();
            if (line.Length == 0) {
                continue;
            }

            System.Console.WriteLine(line);
        }
    }
}
