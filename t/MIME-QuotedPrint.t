use strict;
use warnings;
use lib "t/lib";

use Test::More;

use SPVM 'TestCase::MIME::QuotedPrint';

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count;

{
  ok(SPVM::TestCase::MIME::QuotedPrint->encode_qp());
  ok(SPVM::TestCase::MIME::QuotedPrint->decode_qp());
}

$api->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;
