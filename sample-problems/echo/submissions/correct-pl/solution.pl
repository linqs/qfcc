foreach my $line (<STDIN>) {
    chomp($line);
    if (length($line) == 0) {
        next;
    }

    print "$line\n";
}
