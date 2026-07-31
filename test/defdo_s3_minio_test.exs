defmodule Defdo.S3MinioTest do
  use ExUnit.Case, async: false

  @moduletag :integration
  @moduletag :s3_compatible

  if is_nil(System.get_env("DEFDOS3_S3_ENDPOINT")) do
    @moduletag skip: "set DEFDOS3_S3_ENDPOINT to run the local S3-compatible test"
  end

  @endpoint System.get_env("DEFDOS3_S3_ENDPOINT", "http://127.0.0.1:9000")
  @bucket System.get_env("DEFDOS3_S3_BUCKET", "defdo-test")
  @access_key System.get_env("DEFDOS3_S3_ACCESS_KEY", "test")
  @secret_key System.get_env("DEFDOS3_S3_SECRET_KEY", "test-secret-123")
  @region System.get_env("DEFDOS3_S3_REGION", "us-east-1")

  setup do
    request = s3_request()
    response = Req.put!(request, url: "s3://#{@bucket}")

    assert response.status in [200, 409]

    {:ok, request: request}
  end

  test "S3-compatible storage accepts a presigned URL for an object key containing a space", %{
    request: request
  } do
    key = "defdo-s3-test-#{System.unique_integer([:positive])}/hello world.txt"
    encoded_key = String.replace(key, " ", "%20")
    body = "safe local S3 integration fixture"

    put_url =
      Defdo.S3.presign_url(
        url: "s3://#{@bucket}/#{key}",
        endpoint_url: @endpoint,
        access_key_id: @access_key,
        secret_access_key: @secret_key,
        region: @region,
        method: :put
      )

    assert put_url =~ "/#{@bucket}/#{encoded_key}?"
    assert put_url =~ "X-Amz-Algorithm=AWS4-HMAC-SHA256"
    assert put_url =~ "X-Amz-Signature="
    assert %{status: 200} = Req.put!(put_url, body: body)

    on_exit(fn -> Req.delete(request, url: "s3://#{@bucket}/#{encoded_key}") end)

    assert %{status: 200, body: ^body} =
             Req.get!(request, url: "s3://#{@bucket}/#{encoded_key}")
  end

  defp s3_request do
    Req.new(
      plugins: [Defdo.S3],
      aws_endpoint_url_s3: @endpoint,
      aws_sigv4: [
        service: :s3,
        access_key_id: @access_key,
        secret_access_key: @secret_key,
        region: @region
      ]
    )
  end
end
