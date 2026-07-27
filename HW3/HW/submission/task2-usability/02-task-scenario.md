# Usability Task Scenario

## Participant-facing scenario

> Bạn đang muốn mua một chiếc iPhone 15 Pro Max trên EShop lần đầu tiên. Hãy tạo
> tài khoản thử nghiệm bằng thông tin được phát, tìm đúng sản phẩm, đặt mua một
> chiếc và sử dụng mã ưu đãi `SAVE10`. Hoàn thành đơn hàng và cho người điều phối
> biết khi bạn tin rằng việc mua hàng đã thành công.

The participant receives a goal, not a list of UI steps. Do not add instructions
such as which button to click, where the search field is, or when to sign in.

## Session card prepared privately

Provide one card per participant:

```text
Study code: P__
Test name: Participant __
Test email: p__-hw03@example.test
Test password: Shopping1!
Coupon supplied by the scenario: SAVE10
```

Use a unique test email for every session. Do not reuse participants' personal
passwords.

## Start condition

- Browser is open at the EShop Home screen.
- Cart and local storage are empty.
- Backend contains seed products and an unused `SAVE10` entitlement for the
  session's newly created test account.
- Recording status is confirmed.

## End conditions

- Success: the participant reaches the visible Checkout success state.
- Abandoned: the participant explicitly stops.
- Terminated: 10 minutes elapsed or the moderator must take control.

## What the moderator must not do

- Point at controls or tell the participant which link to select.
- Explain the first-click add-to-cart behavior.
- Correct an input unless the participant asks a general clarification.
- Reveal that known bugs exist.
- interpret or discuss SUS questions before the participant answers them.
