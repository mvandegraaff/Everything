# .latexmkrc
use File::Basename;

# Custom subroutine to compile subfiles
add_cus_dep('tex', 'pdf', 0, 'subfile_pdf');
sub subfile_pdf {
    my ($base_name, $path) = fileparse(shift);
    my $dir = $path ? "$path/" : "";

    system("latexmk -pdf -aux-directory=out $dir$base_name.tex");
    return 0;
}

# Hook into LaTeXmk's clean routine to remove auxiliary files
add_cus_dep('tex', 'clean', 0, 'clean_aux_files');
sub clean_aux_files {
    my ($base_name, $path) = fileparse(shift);
    my $dir = $path ? "$path/" : "";

    system("rm -f out/$base_name.*");
    return 0;
}

# Ensure LaTeXmk knows to clean auxiliary files on 'latexmk -C'
push @clean_ext, qw(aux log out toc fdb_latexmk fls nav snm vrb xdv);

# Output directory for auxiliary files
$aux_dir = 'out';
