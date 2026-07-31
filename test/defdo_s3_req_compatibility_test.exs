defmodule Defdo.S3ReqCompatibilityTest do
  use ExUnit.Case, async: true

  test "attaches and prepares with Req 0.7 without current_request_steps" do
    request = Req.new(plugins: [Defdo.S3], url: "s3://")
    prepared = Req.Request.prepare(request)

    assert prepared.url.scheme == "https"
    assert prepared.url.host == "s3.amazonaws.com"
    assert prepared.options[:aws_sigv4] == nil

    assert Enum.any?(prepared.response_steps, fn {name, _step} ->
             name == :req_s3_decode_body
           end)
  end
end
