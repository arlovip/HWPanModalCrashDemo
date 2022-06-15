# HWPanModalCrashDemo

HWPanModal crash demo only.

```
Fix bug: the app will crash after the table view reloads data via calling [tableView reloadData] if the user scrolls to the bottom.
We remove some element and reload data, for example, [self.dataSource removeLastObject], the previous saved scrollViewYOffset value
will be great than or equal to the current actual offset(i.e. scrollView.contentOffset.y). At this time, if the method
[scrollView setContentOffset:CGPointMake(0, self.scrollViewYOffset) animated:NO] is called, which will trigger KVO recursively.
So scrollViewYOffset must be less than or equal to the actual offset
```

See crash gif:

![modal.gif](https://s2.loli.net/2022/06/15/mYdP267EOonAUkC.gif)