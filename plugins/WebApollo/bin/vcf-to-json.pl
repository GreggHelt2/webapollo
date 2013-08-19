#!/usr/bin/env perl
use strict;
use FindBin qw($RealBin);
use lib "$RealBin/../perl5";
use JBlibs;

use Bio::WebApollo::Cmd::VcfToJson;

exit Bio::WebApollo::Cmd::VcfToJson->new(@ARGV)->run;

__END__

=head1 NAME

vcf-to-json.pl - format vcf data into WebApollo JSON format from an annotation file

=head1 USAGE

  flatfile-to-json.pl                                                         \
      --vcf <VCF file>                                                        \
      --trackLabel <track identifier>                                         \
      [ --out <output directory> ]                                            \
      [ --key <human-readable track name> ]                                   \
      [ --className <CSS class name for displaying features> ]                \
      [ --autocomplete <none|label|alias|all> ]                               \
      [ --getType ]                                                           \
      [ --getPhase ]                                                          \
      [ --getSubfeatures ]                                                    \
      [ --getLabel ]                                                          \
      [ --urltemplate "http://example.com/idlookup?id={id}" ]                 \
      [ --arrowheadClass <CSS class> ]                                        \
      [ --subfeatureClasses '{ JSON-format subfeature class map }' ]          \
      [ --clientConfig '{ JSON-format extra configuration for this track }' ] \
      [ --thinType <BAM -thin_type> ]                                         \
      [ --thicktype <BAM -thick_type>]                                        \
      [ --type <feature types to process> ]                                   \
      [ --nclChunk <chunk size for generated NCLs> ]                          \
      [ --compress ]                                                          \
      [ --sortMem <memory in bytes to use for sorting> ]                      \
      [ --webApollo ]                                                         \
      [ --renderClassName <CSS class for rendering transcript> ]

=head1 ARGUMENTS

=head2 Required

=over 4

=item --vcf <vcf file>

Process a VCF file 

=item --trackLabel <track identifier>

Unique identifier for this track.  Required.

=back

=head2 Optional

=over 4

=item --help | -h | -?

Display an extended help screen.

=item --key '<text>'

Human-readable track name.

=item --out <output directory>

Output directory to write to.  Defaults to "data/".

=item --className <CSS class name for displaying features>

CSS class for features.  Defaults to "feature".

=item --autocomplete <none|label|alias|all>

Make these features searchable by their C<label>, by their C<alias>es,
both (C<all>), or C<none>.  Defaults to C<none>.

=item --getType

Include the type of the features in the JSON.

=item --getPhase

Include the phase of the features in the JSON.

=item --getSubfeatures

Include subfeatures in the JSON.

=item --getLabel

Include a label for the features in the JSON.

=item --urltemplate "http://example.com/idlookup?id={id}"

Template for a URL to be visited when features are clicked on.

=item --arrowheadClass <CSS class>

CSS class for arrowheads.

=item --subfeatureClasses '{ JSON-format subfeature class map }'

CSS classes for each subfeature type, in JSON syntax.  Example:

  --subfeatureClasses '{"CDS": "transcript-CDS", "exon": "transcript-exon"}'

=item --clientConfig '{ JSON-format extra configuration for this track }'

Extra configuration for the client, in JSON syntax.  Example:

  --clientConfig '{"featureCss": "background-color: #668; height: 8px;", "histScale": 2}'

=item --type <feature types to process>

Only process features of the given type.  Can take either single type
names, e.g. "mRNA", or type names qualified by "source" name, for
whatever definition of "source" your data file might have.  For
example, "mRNA:exonerate" will filter for only mRNA features that have
a source of "exonerate".

=item --nclChunk <chunk size for generated NCLs>

NCList chunk size; if you get "json text or perl structure exceeds
maximum nesting level" errors, try setting this lower (default:
50,000).

=item --compress

Compress the output, making .jsonz (gzipped) JSON files.  This can
save a lot of disk space, but note that web servers require some
additional configuration to serve these correctly.

=item --sortMem <bytes>

Bytes of RAM to use for sorting features.  Default 512MB.

=item --webApollo

Write out JSON for use with WebApollo instead of Jbrowse. As of 8/2012 this entails 1) joining all CDS features into one big wholeCDS feature that spans from the start of the first CDS to the end of the last CDS and 2) merging UTRs into exon features. 

=item --renderClassName <css class>

CSS class for rendering transcripts.  Required with --webApollo flag.

=back

=head2 BED-specific

=over 4

=item --thinType <type>

=item --thickType <type>

Correspond to C<<-thin_type>> and C<<-thick_type>> in
L<Bio::FeatureIO::bed>.  Do C<<perldoc Bio::FeatureIO::bed>> for
details.

=back

=cut
