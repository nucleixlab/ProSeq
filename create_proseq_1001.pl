#!/usr/bin/perl
# Create *_proseq_1001.txt
# written by : Aditya
$ncbi_file = "list_ncbi_id";
$ncbi_count = 0;
open(NCBI,"$ncbi_file");
while(<NCBI>)
{
  chomp($ncbi = $_);
  $fna_file = $ncbi.'.fna';
  $geneinfo_file = $ncbi.'_coordinates.txt';
  $proseq_file = $ncbi.'_proseq_1001nt.txt';
  open(FH,"$fna_file") ||die "File $fna_file doesn't exist.";
  chomp(@arr=<FH>);close(FH);
  shift(@arr);
  $str=join("",@arr);
  open(FH1,"$geneinfo_file") ||die "File $geneinfo_file doesn't exist.";
  chomp(@arr1=<FH1>);
  close(FH1);
 # $lnum=@arr1;
  open(FH2, ">$proseq_file") ||die "File $proseq_file cannot create";
  for($i=0;$i<=$#arr1;$i++)
  {
    @fields=split /\t/, $arr1[$i];
    if ($fields[2] eq '+')
      {
      $seq=substr($str,$fields[0]-501,1001);
	if (length($seq) eq '1001')
	 { print FH2 "\>$ncbi\t$arr1[$i]\n";
	  print FH2 "$seq\n";
	 }
      }
      elsif ($fields[2] eq '-')
      {
      $seq=substr($str,$fields[1]-501,1001);
      $revcomp=reverse $seq;
      $revcomp =~ tr/ACGTacgt/TGCAtgca/;
	if (length($revcomp) eq '1001')
	  {
	  print FH2 "\>$ncbi\t$arr1[$i]\n";
	  print FH2 "$revcomp\n";
	  }
      }
  }
  print 
}
