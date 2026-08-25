# CHANGELOG

## 0.2.0

### Every requirement declares the line it resolves on

- `req` `~> 0.5.6 or ~> 0.7.0` -> `~> 0.7` (resolves 0.7.1). An accumulated
  `or` list grows a clause per bump and never loses one.
- `ex_doc` `>= 0.0.0` -> `~> 0.40`. A `>=` with no ceiling claims every version
  ever published works, and nothing verified that.

Minor rather than patch: no source changed, but a narrowed requirement is not
something a consumer can take blindly.

**Consumers must edit to follow.** `defdo_theme`, `defdo_theme_hub`,
`defdo_uploader` and `defdo_cms` all declare `defdo_s3 ~> 0.1.0` — three
segments, so they cap at `< 0.2.0` and will silently stay on 0.1.x. Hex
resolves the highest satisfiable version without reporting a conflict. They
need `~> 0.2`.

1 doctest, 8 tests, 0 failures. `mix hex.outdated` empty.

## v0.1.2 — 2026-07-29

  * Support Req 0.7.x alongside Req 0.5.x.
  * Skip the removed `Req.Request.current_request_steps` field on Req 0.7.x.
  * Remove the Req 0.6.x dependency constraint.

## v0.1.1 — 2026-07-17

  * deps: bump `req` to 0.6.3 and `ex_doc` to 0.40.3 (hex.outdated green).

## v0.1.0 — 2026-07-01

  * Forked from [wojtekmach/req_s3](https://github.com/wojtekmach/req_s3) v0.2.3.
  * Renamed module to `Defdo.S3` for defdo ecosystem ownership.
  * Published under the `defdo` Hex organization.

---

Previous releases from upstream `req_s3`:

## v0.2.3

  * Use scheme and port from `endpoint_url`.

## v0.2.2 (2024-08-14)

  * Add `:aws_endpoint_url_s3` option.

  * Document `:handle_s3_url` step.

## v0.2.1 (2024-08-01)

  * Add support for `s3://` (list buckets) endpoint.

  * Add support for `s3://{bucket}?versions` (list versions) and similar endpoints.

  * Automatically use `AWS_ENDPOINT_URL_S3`, `AWS_ACCESS_KEY_ID`, and
    `AWS_SECRET_ACCESS_KEY` system env vars.

## v0.2.0 (2024-07-18)

  * Support Req v0.5.

  * Change decoded response for `s3://{bucket}` endpoint. Instead of listing
    just object keys, return decoded XML response.

  * Add [`ReqS3.presign_url/1`].

  * Add [`ReqS3.presign_form/1`].

## v0.1.1 (2023-09-01)

  * Support Req v0.4.

## v0.1.0 (2022-08-24)

  * Initial release

[`ReqS3.presign_url/1`]: https://hexdocs.pm/req_s3/ReqS3.html#presign_url/1
[`ReqS3.presign_form/1`]: https://hexdocs.pm/req_s3/ReqS3.html#presign_form/1
