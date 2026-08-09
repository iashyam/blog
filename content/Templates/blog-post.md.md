<%*
const postTitle = await tp.system.prompt("Post title");

const slug = postTitle
  .toLowerCase()
  .trim()
  .replace(/[^\w\s-]/g, "")
  .replace(/\s+/g, "-");

const date = tp.date.now("YYYY-MM-DD");
await tp.file.rename(`${date}-${slug}`);
%>
---
title: "<% postTitle %>"
date: <% tp.date.now("YYYY-MM-DD") %>
categories:
  - Writing
tags: []
math: false
layout: post
image: ""
---

# <% postTitle %>